require "test_helper"

describe VotesController do
  it "voting redirects to login page if not logged in" do
      post new_vote_path(works(:wilco).id), params:
      { vote:
        { work: works(:wilco)
        }
      }
      must_redirect_to login_page_path
    end

    
end
