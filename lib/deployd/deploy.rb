require_dependency "grit"

module Deployd
  class Deploy

    attr_accessor :id

    def self.root_path
      File.join(Rails.root, '..', '..')
    end

    def self.releases_path
      File.join(root_path, 'releases')
    end

    def self.git_repo_path
      File.join(root_path, 'shared', 'cached-copy')
    end

    def self.repo_url
      "https://github.com/#{Deployd.github_repo}"
    end

    def self.all
      Pathname.new(releases_path).children.select { |c| c.directory? }.collect do |pathname|
        Deploy.new File.basename(pathname)
      end.reverse
    end

    def self.pending_pull_request_merges
      previous_deploy = Deploy.all.first
      return nil unless previous_deploy

      changes = previous_deploy.repo.commits_between(previous_deploy.revision, "HEAD")
      changes.select { |c| c.message =~ /Merge pull request/ }
    end

    def initialize(id)
      @id = id
      @path = File.join(Deploy.releases_path, @id)

      unless File.exists?(@path)
        raise UnknownDeployError
      end
    end

    def revision_path
      File.join(@path, 'REVISION')
    end

    def revision
      @revision ||= File.open(revision_path, "rb").read.strip
    end

    def time
      @time ||= DateTime.parse @id
    end

    def revision_url
      "#{Deploy.repo_url}/commit/#{revision}"
    end

    def repo
      @repo ||= ::Grit::Repo.new Deploy.git_repo_path
    end

    def changes
      @changes ||= repo.commits_between(previous_deploy.revision, revision)
    end

    def pull_request_merges
      @pull_request_merges ||= changes.select { |c| c.message =~ /Merge pull request/ }
    end

    def previous_deploy
      return @previous_deploy if @previous_deploy

      deploys = Deploy.all
      index = deploys.index { |d| d.id == id }

      @previous_deploy ||= deploys[index + 1]
    end

  end

  class UnknownDeployError < StandardError; end
end
