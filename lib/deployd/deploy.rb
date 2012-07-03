module Deployd
  class Deploy

    def self.root_path
      File.join(Rails.root, '..', '..')
    end

    def self.releases_path
      File.join(root_path, 'releases')
    end

    def self.git_repo_path
      File.join(root_path, 'shared', 'cached_copy')
    end

    def self.all
      Pathname.new(releases_path).children.select { |c| c.directory? }.collect do |pathname|
        Deploy.new pathname
      end
    end

    def initialize(pathname)
      @pathname = pathname
    end

    def revision_path
      File.join(@pathname, 'REVISION')
    end

    def revision
      @revision ||= File.open(revision_path, "rb").read
    end

    def time
      @time ||= DateTime.parse File.basename(@pathname)
    end

  end
end
