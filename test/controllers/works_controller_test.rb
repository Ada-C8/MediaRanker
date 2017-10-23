require 'test_helper'

describe "WorkController" do

  # describe "Routing works as expected" do
  #   it "should successfully route to index" do
  #     get works_path
  #     must_respond_with :success
  #   end
  #
  #   it "should successfully route to show" do
  #     get work_path(works(:harrypot).id)
  #     must_respond_with :success
  #   end
  #
  #   it "it won't route to show for an id that doesn't exist" do
  #     id = works(:traveller).id
  #     delete work_path(id)
  #     get work_path(id)
  #     must_redirect_to works_path
  #   end
  #
  #   it "should successfully route to new" do
  #     get new_work_path
  #     must_respond_with :success
  #   end
  #
  #   # it "should successfully route to create" do
  #   #   post works_path
  #   #   must_respond_with :success
  #   # end
  #
  #   it "should successfully route to edit" do
  #     get edit_work_path(works(:harrypot).id)
  #     must_respond_with :success
  #   end
  #
  #   # it "should successfully route to update" do
  #   #   patch work_path(works(:harrypot).id)
  #   #   must_respond_with :success
  #   # end
  #   #
  #   # it "should successfully route to update" do
  #   #   put work_path(works(:harrypot).id)
  #   #   must_respond_with :success
  #   # end
  #   #
  #   # it "should successfully route to destroy" do
  #   #   delete work_path(works(:harrypot).id)
  #   #   must_respond_with :success
  #   # end
  # end
  #
  # describe "Changes to the database" do
  #
  #   it "can create a new work" do
  #     proc { post works_path, params: { work: {category: "work", title: "some work", creator: "some writer", publication_year: 2017, description: "something"}  }}.must_change 'Work.count', 1
  #     must_respond_with :redirect
  #   end
  #
  #   it "won't create a new work when parameters are missing" do
  #     proc { post works_path, params: { work: {category: "work"} }}.must_change 'Work.count', 0
  #     must_respond_with :bad_request
  #   end
  #
  #   it "can update a work" do
  #     put work_path(works(:traveller).id), params: {work: {category: "album", title: "some album", creator: "some artist", publication_year: 2017, description: "something"} }
  #
  #     # find the work with that ID in the database
  #     work = Work.find(works(:traveller).id)
  #
  #     # verify the work was changed properly
  #     work.title.must_equal "some album"
  #     work.description.must_equal "something"
  #
  #     must_respond_with :redirect
  #   end
  #
  #   it "can't update a work with missing parameters" do
  #     put work_path(works(:traveller).id), params: {work: {category: "", title: "New title!"} }
  #     work = Work.find(works(:traveller).id)
  #     work.title.wont_equal "New title!"
  #   end
  #
  #   it "can delete an existing work" do
  #     proc { delete work_path(works(:traveller).id) }.must_change 'Work.count', -1
  #     must_respond_with :redirect
  #   end
  #
  #   # it "can't delete an non existing work" do
  #   #   id = works(:traveller).id
  #   #   proc { delete work_path(id)}.must_change 'Work.count', -1
  #   #   proc { delete work_path(id)}.must_respond_with :error
  #   #   must_respond_with :redirect
  #   # end
  #
  # end

  describe "require_login" do

    describe "Logged in users" do
      let(:user) { users(:one) }
      let(:existing_auth_hash) { OmniAuth::AuthHash.new(auth_hash(user)) }
      let(:new_auth_hash) { OmniAuth::AuthHash.new(auth_hash_github) }
      let(:invalid_auth_hash) { OmniAuth::AuthHash.new(very_bad_hash) }

      describe "show" do
        it "returns 404 not_found for a work that D.N.E." do
          login(user, :github)
          get work_path(Work.last.id + 1)
          flash[:message].must_equal "Could not find this work"
        end

        it "succeeds for a work that exists" do
          login(user, :github)
          get work_path(Work.first)
          must_respond_with :success
        end

        it "can access top_media" do
          login(user, :github)
          get top_media_path
          must_respond_with :success
        end

        it "can access new" do
          login(user, :github)
          get new_work_path
          must_respond_with :success
        end

        it "can access show" do
          login(user, :github)
          get work_path(Work.first)
          must_respond_with :success
        end

        it "can access index" do
          login(user, :github)
          get works_path
          must_respond_with :success
        end

      


        it "can access destroy" do
          login(user, :github)
          delete work_path(Work.first.id)
          must_respond_with :redirect
        end

      end
    end

    describe "Guest users" do
      it "can access top_media" do
        get top_media_path
        must_respond_with :success
      end

      it "cannot access new" do
        get new_work_path
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end

      it "cannot access show" do
        get work_path(Work.first.id)
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end

      it "cannot access index" do
        get works_path
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end

      it "cannot access create" do
        post works_path
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end

      it "cannot access update" do
        patch work_path(Work.first.id)
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end

      it "cannot access update" do
        put work_path(Work.first.id)
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end



      it "cannot access destroy" do
        delete work_path(Work.first.id)
        must_redirect_to root_path
        flash[:message].must_equal "You must be logged in to access this section"
      end
    end
  end

end
