module Deployd
  module ApplicationHelper

    def issue_commit_link(commit)
      id = /#(\d+)/.match(commit.message)[1]
      link_to "View on github", "#{Deploy.repo_url}/issues/#{id}", :class => 'btn', :target => :blank
    end

  end
end
