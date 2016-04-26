require 'rails_helper'

RSpec.describe TamuUsersController, type: :controller do

    def cas_log_in(user)
      cas_hash = { user: user.netid, extra_attributes: { 'tamuEduPersonNetID' => user.netid } }
      session[:cas] = cas_hash
    end
    

    describe "GET #index" do
        it "populates an array of tamu users if logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)
            get :index
            expect(assigns(:tamu_users)).to eq([tamu_user])
        end
        
        it "renders the :index view if logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)

            get :index
            expect(response).to render_template :index
        end
        
        it "does not populate an array of tamu users if not logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :index
            expect(assigns(:tamu_users)).to_not eq([tamu_user])
        end
        
        it "does not render the :index view if not logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :index
            expect(response).to_not render_template :index
        end
        
        it "redirects to root path if not tamu_user" do
          controller.log_out
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
          get :index
          expect(response).to redirect_to root_path
        end
        
    end
    
    describe "GET #show" do
        context "not logged in" do
          # TODO: the filter will automatically redirect to CAS and log in if it can, so
          # this spec doesn't really work unless they are logged in as an agency already
          # it "does not assign the requested tamu user to @tamu_user if not logged in" do
          #     tamu_user = FactoryGirl.create(:tamu_user, :default)
          #     get :show, id: tamu_user
          #     expect(assigns(:tamu_user)).to_not eq(tamu_user)
          # end

          it "it does not render the :show view if not logged in" do
              tamu_user = FactoryGirl.create(:tamu_user, :default)
              get :show, id: tamu_user
              expect(response).to_not render_template :show
          end
        end

        context "logged in" do
          before :each do
            @tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(@tamu_user)
          end
          it "assigns the requested tamu user to @tamu_user if logged in" do
            get :show, id: @tamu_user
            expect(assigns(:tamu_user)).to eq(@tamu_user)
          end

          it "it renders the :show view if logged in" do
            get :show, id: @tamu_user
            expect(response).to render_template :show
          end
        end
        
        
        it "redirects to root path if not tamu_user and is not connected to tamu_user" do
          controller.log_out
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
          get :show, id: FactoryGirl.create(:tamu_user, :default)
          expect(response).to redirect_to root_path
        end
        
    end
    
    describe 'POST unapprove' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default, :professor)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @tamu_user if logged in as admin" do
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        expect(assigns(:tamu_user)).to eq(@tamu_user)
      end

      it "changes @tamu_user's role field if logged in as admin" do
        post :unapprove_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @tamu_user.reload
        expect(@tamu_user.role).to eq("unapproved_professor")
      end

      it "redirects to the approved faculty if logged in as admin" do
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to tamu_users_path
      end
      
      it "should not locate the requested @tamu_user if logged not in as admin" do
        controller.log_out
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        expect(assigns(:tamu_user)).to_not eq(@tamu_user)
      end

      it "should not change faculty's role field if not logged in as admin" do
        controller.log_out
        post :unapprove_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @tamu_user.reload
        expect(@tamu_user.role).to_not eq("unapproved_professor")
      end

      it "should not redirect to the approved faculty if not logged in as admin" do
        controller.log_out
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to_not redirect_to tamu_users_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :unapprove_professor, id: @tamu_user
            expect(response).to redirect_to root_path
      end
      
    end
    
    describe "GET #edit" do
        it "assigns the requested tamu user to @tamu_user if logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)
            get :edit, id: tamu_user
            expect(assigns(:tamu_user)).to eq(tamu_user)
        end
        it "it renders the :edit view if logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)
            get :edit, id: tamu_user
            expect(response).to render_template :edit
        end
        
        it "does not assign the requested tamu user to @tamu_user if not logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :edit, id: tamu_user
            expect(assigns(:tamu_user)).to_not eq(tamu_user)
        end
        it "it does not renders the :edit view if not logged in" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :edit, id: tamu_user
            expect(response).to_not render_template :edit
        end
        
        it "it renders the root path if not current tamu_user" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)
            get :edit, id: FactoryGirl.create(:tamu_user, :updated)
            expect(response).to redirect_to root_path
        end 
    end

    describe 'PUT update' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        controller.log_in(@tamu_user)
      end
  
      context "valid attributes and logged in" do
        context "everything goes well" do
          it "located the requested @tamu_user" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
            expect(assigns(:tamu_user)).to eq(@tamu_user)
          end

          it "changes @tamu_user's attributes, but not role" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :updated)
            @tamu_user.reload
            expect(@tamu_user.name).to eq("Updated Smith")
            expect(@tamu_user.role).to eq("student")
            expect(@tamu_user.email).to eq("new_prof@tamu.edu")
          end

          it "redirects to the updated tamu_user" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
            expect(response).to redirect_to @tamu_user
          end
        end
        context "update fails" do
          before :each do
            expect_any_instance_of(TamuUser).to receive(:update_attributes).and_return(nil)
          end

          it "does not change @tamu_user's attributes" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
            @tamu_user.reload
            expect(@tamu_user.name).to eq("John Smith")
            expect(@tamu_user.role).to eq("student")
            expect(@tamu_user.email).to eq("test@tamu.edu")
          end

          it "re-renders the edit method" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
            expect(response).to render_template :edit
          end
        end
        
      end
  
      context "invalid attributes" do
        it "locates the requested @tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          expect(assigns(:tamu_user)).to eq(@tamu_user)
        end
    
        it "does not change @tamu_user's attributes" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          @tamu_user.reload
          expect(@tamu_user.name).to eq("John Smith")
          expect(@tamu_user.role).to eq("student")
          expect(@tamu_user.email).to eq("test@tamu.edu")
        end
    
        it "re-renders the edit method" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          expect(response).to render_template :edit
        end
      end
      
      context "valid attributes and not logged in" do
        context "everything goes well" do
          it "located the requested @tamu_user" do
            controller.log_out
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
            expect(assigns(:tamu_user)).to_not eq(@tamu_user)
          end
        end
      end
      
    end
    
    describe 'DELETE destroy' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        controller.log_in(@tamu_user)
      end
      
      it "deletes the tamu_user" do
        expect{
          delete :destroy, id: @tamu_user        
        }.to change(TamuUser,:count).by(-1)
      end
      
      it "does not delete the tamu_user if not logged in" do
        controller.log_out
        expect{
          delete :destroy, id: @tamu_user        
        }.to change(TamuUser,:count).by(0)
      end
        
      it "redirects to tamu_user#index" do
        delete :destroy, id: @tamu_user
        expect(response).to redirect_to tamu_users_path
      end
    end

    describe 'GET #new' do

      it "should not be accessible if not authenticated" do
        get :new
        expect(response).to redirect_to root_path
      end

      context "cas authenticated" do
        before :each do
          @tamu_user = FactoryGirl.build(:tamu_user, :default)
          cas_log_in(@tamu_user)
        end

        it "should render the new view" do
          get :new
          expect(response).to render_template :new
        end

        it "should default the email to their tamu one" do
          get :new
          expect(assigns(:tamu_user).email).to include(@tamu_user.netid)
        end

        it "should not be accessible if already in the system" do
          @tamu_user.save
          controller.log_in(@tamu_user)
          get :new
          expect(response).to redirect_to root_path
        end

        it "should not be accessible by agencies" do
          agency = FactoryGirl.create(:agency, :default)
          controller.log_in(agency)
          get :new
          expect(response).to redirect_to root_path
        end
      end

    end

    describe 'POST #create' do
      #TODO: validation stuffs, increases count by 1

      it "should not be accessible if not authenticated" do
        post :create
        expect(response).to redirect_to root_path
      end

      context "cas authenticated" do
        before :each do
          @tamu_user = FactoryGirl.build(:tamu_user, :default)
          cas_log_in(@tamu_user)
        end

        it "should not be accessible if already in the system" do
          @tamu_user.save
          controller.log_in(@tamu_user)
          post :create
          expect(response).to redirect_to root_path
        end

        it "should not be accessible by agencies" do
          agency = FactoryGirl.create(:agency, :default)
          controller.log_in(agency)
          post :create
          expect(response).to redirect_to root_path
        end

        context "invalid attributes" do
          def attributes
            FactoryGirl.attributes_for(:tamu_user, :invalid)
          end
          it "should redirect to the new tamu user" do
            post :create, tamu_user: attributes
            expect(response).to render_template :new
          end
        end

        context "valid attributes" do
          it "should log in as the created tamu user" do
            expect(FactoryGirl.build(:tamu_user, :default)).to be_valid
            post :create, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
            expect(controller).to be_logged_in
          end
        end
      end
    end

    describe "POST #make_admin" do
      context "not logged in" do
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default, :not_admin)
        end

        it "should redirect to the log in page" do
          post :make_admin, id: @tamu_user.id
          expect(response).to redirect_to my_login_path
        end

        it "should not make the user an admin" do
          post :make_admin, id: @tamu_user.id
          @tamu_user.reload
          expect(@tamu_user.admin).to eq(false)
        end
      end

      context "logged in as nonadmin" do
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default, :not_admin)
          controller.log_in @tamu_user
        end

        it "should redirect to the homepage" do
          post :make_admin, id: @tamu_user.id
          expect(response).to redirect_to root_path
        end

        it "should not make the user an admin" do
          post :make_admin, id: @tamu_user.id
          @tamu_user.reload
          expect(@tamu_user.admin).to eq(false)
        end
      end

      context "logged in as admin" do
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default, :not_admin)
          @admin = FactoryGirl.create(:tamu_user, :updated, :admin)
          controller.log_in @admin
        end

        it "should redirect to the users index" do
          post :make_admin, id: @tamu_user.id
          expect(response).to redirect_to tamu_users_path
        end
        it "should make the user an admin" do
          post :make_admin, id: @tamu_user.id
          @tamu_user.reload
          expect(@tamu_user.admin).to eq(true)
        end
      end

    end

end
