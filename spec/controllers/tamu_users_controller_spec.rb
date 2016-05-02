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
    
    describe "GET #unapproved faculty index" do
        it "populates an array of tamu_users if logged in as admin" do
            admin = FactoryGirl.create(:tamu_user, :default, :admin)
            controller.log_in(admin)
            tamu_user = FactoryGirl.create(:tamu_user, :default, :unapproved_professor)
            get :unapproved_professor_index
            expect(assigns(:tamu_users)).to eq([tamu_user])
        end
        
        it "does not populate an array of tamu_users if not logged in as admin" do
            tamu_user = FactoryGirl.create(:tamu_user, :default, :unapproved_professor)
            get :unapproved_professor_index
            expect(assigns(:tamu_users)).to_not eq([tamu_user])
        end
        
        it "renders the unapproved index view if logged in as admin" do
            admin = FactoryGirl.create(:tamu_user, :default, :admin)
            controller.log_in(admin)
            get :unapproved_professor_index
            expect(response).to render_template :unapproved_professor_index
        end
        
        it "does not render the index view if not logged in as admin" do
            get :unapproved_professor_index
            expect(response).to_not render_template :unapproved_professors_index
        end
        
        it "redirects to root path if not admin" do
            not_an_admin = FactoryGirl.create(:tamu_user, :default, :not_admin)
            controller.log_in(not_an_admin)
            get :unapproved_professor_index
            expect(response).to redirect_to root_path
        end
    end
    
    describe "GET #show" do
        context "not logged in" do
          it "does not assign the requested tamu user to @tamu_user if not logged in" do
              tamu_user = FactoryGirl.create(:tamu_user, :default)
              get :show, id: tamu_user
              expect(assigns(:tamu_user)).not_to eq(tamu_user)
          end

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
        
        context "agency logged in" do
          before :each do
            @tamu_user =  FactoryGirl.create(:tamu_user, :default)
            @agency = FactoryGirl.create(:agency, :default, :approved)
            controller.log_in(@agency)
          end
        
          it "redirects to root path if not tamu_user and is not connected to tamu_user" do
            get :show, id: @tamu_user
            expect(response).to redirect_to root_path
          end

          it "renders the show view if connected to tamu_user" do
            @project = FactoryGirl.create(:project, :default, agency: @agency)
            @tamu_user.projects << @project
            get :show, id: @tamu_user
            expect(response).to render_template :show
          end
        end
        
    end
    
    describe 'POST approve_professor' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default, :unapproved_professor)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @tamu_user if logged in as admin" do
        post :approve_professor, id: @tamu_user
        expect(assigns(:professor)).to eq(@tamu_user)
      end

      it "changes @tamu_user's role field if logged in as admin" do
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @tamu_user.reload
        expect(@tamu_user.role).to eq("professor")
      end

      it "redirects to the tamu_users if there is no unapproved agencies left if logged in as admin" do
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to tamu_users_path
      end
      
      it "redirects to the unapproved faculty index if there are unapproved faculty left if logged in as admin" do
        FactoryGirl.create(:tamu_user, :default, :unapproved_professor)
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to unapproved_professors_index_path
      end
      
      
      it "should not locate the requested @tamu_user if not logged in" do
        controller.log_out
        post :approve_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :unapproved_professor)
        expect(assigns(:tamu_user)).to_not eq(@tamu_user)
      end

      it "does not changes @tamu_user's role field if not logged in" do
        controller.log_out
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @tamu_user.reload
        expect(@tamu_user.role).to eq("unapproved_professor")
      end

      it "does not redirects to the approved agencies if there is no unapproved agencies left if not logged in" do
        controller.log_out
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to_not redirect_to tamu_users_path
      end
      
      it "does not redirects to the unapproved agencies if there are unapproved agencies left if not logged in" do
        controller.log_out
        FactoryGirl.create(:tamu_user, :default, :unapproved_professor)
        post :approve_professor, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to_not redirect_to unapproved_agencies_index_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :approve_professor, id: @tamu_user
            expect(response).to redirect_to root_path
      end
    end
    
    describe 'POST unapprove_professor' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default, :professor)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @tamu_user if logged in as admin" do
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        expect(assigns(:professor)).to eq(@tamu_user)
      end

      it "changes @tamu_user's role field if logged in as admin" do
        post :unapprove_professor, id: @tamu_user#, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        @tamu_user.reload
        expect(@tamu_user.role).to eq("unapproved_professor")
      end

      it "redirects to the tamu_users_path if logged in as admin" do
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        expect(response).to redirect_to tamu_users_path
      end
      
      it "should not locate the requested @tamu_user if logged not in as admin" do
        controller.log_out
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        expect(assigns(:professor)).to_not eq(@tamu_user)
      end

      it "should not change @tamu_user's professor field if not logged in as admin" do
        controller.log_out
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        @tamu_user.reload
        expect(@tamu_user.role).to eq("professor")
      end

      it "should not redirect to the professor agencies if not logged in as admin" do
        controller.log_out
        post :unapprove_professor, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
        expect(response).to_not redirect_to tamu_users_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :unapprove_professor, id: @tamu_user
            expect(response).to redirect_to root_path
      end
    end
    
    
    describe 'POST block_user' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default, :not_admin)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @tamu_user if logged in as admin" do
        post :block_user, id: @tamu_user
        expect(assigns(:tamu_user)).to eq(@tamu_user)
      end

      it "changes @tamu_user's blocked field if logged in as admin" do
        post :block_user, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @tamu_user.reload
        expect(@tamu_user.blocked).to eq(true)
      end
      
      it "does not changes @tamu_user's blocked field if logged in as admin and tamu_user is admin" do
        @tamu_user.admin = true
        @tamu_user.save
        post :block_user, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        expect(@tamu_user.reload).not_to be_blocked
      end
      
      it "should not locate the requested @tamu_user if not logged in" do
        controller.log_out
        post :block_user, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
        expect(assigns(:tamu_user)).to_not eq(@tamu_user)
      end

      it "does not changes @tamu_user's blocked field if not logged in" do
        controller.log_out
        post :block_user, id: @tamu_user#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @tamu_user.reload
        expect(@tamu_user.blocked).to eq(false)
      end
    end
    
    describe 'POST unblock_user' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default, :blocked)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @tamu_user if logged in as admin" do
        post :unblock_user, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :blocked)
        expect(assigns(:tamu_user)).to eq(@tamu_user)
      end

      it "changes @tamu_user's blocked field if logged in as admin" do
        post :unblock_user, id: @tamu_user#, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :professor)
        @tamu_user.reload
        expect(@tamu_user.blocked).to eq(false)
      end
      
      it "should not locate the requested @tamu_user if logged not in as admin" do
        controller.log_out
        post :unblock_user, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :blocked)
        expect(assigns(:tamu_user)).to_not eq(@tamu_user)
      end

      it "should not change @tamu_user's blocked field if not logged in as admin" do
        controller.log_out
        post :unblock_user, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, :blocked)
        @tamu_user.reload
        expect(@tamu_user.blocked).to eq(true)
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

          it "changes @tamu_user's attributes" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :updated, role: "student")
            @tamu_user.reload
            expect(@tamu_user.name).to eq("Updated Smith")
            expect(@tamu_user.role).to eq("student")
            expect(@tamu_user.email).to eq("new_prof@tamu.edu")
          end

          it "redirects to the updated tamu_user" do
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
            expect(response).to redirect_to @tamu_user
          end

          it "can't make students faculty" do
            @tamu_user.role = "student"
            @tamu_user.save
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, role: "professor")
            expect(@tamu_user.reload).not_to be_professor
          end
          it "can't make unapproved faculty faculty" do
            @tamu_user.role = "unapproved_professor"
            @tamu_user.save
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, role: "professor")
            expect(@tamu_user.reload).not_to be_professor
          end
          it "can make faculty back into students" do
            @tamu_user.role = "professor"
            @tamu_user.save
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, role: "student")
            expect(@tamu_user.reload).to be_student
          end
          it "can't make faculty unapproved" do
            @tamu_user.role = "professor"
            @tamu_user.save
            put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default, role: "unapproved_professor")
            expect(@tamu_user.reload).to be_professor
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
        }.not_to change(TamuUser,:count)
      end

      it "does not delete the tamu_user if a master admin" do
	@tamu_user.master_admin = true
	@tamu_user.save
        expect{
          delete :destroy, id: @tamu_user
        }.not_to change(TamuUser,:count)
      end

      it "does not delete the tamu_user if not the one logged in" do
	other = FactoryGirl.create(:tamu_users);
        controller.log_out
        expect{
          delete :destroy, id: other
        }.not_to change(TamuUser,:count)
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

        it "should not be accessible by tamu_users" do
          tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in(tamu_user)
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

        it "should not be accessible by tamu_users" do
          tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in(tamu_user)
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

    describe "POST #demote_admin" do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default, :not_admin)
        @admin = FactoryGirl.create(:tamu_user, :updated, :admin)
      end
      def execute
        post :demote_admin, id: @admin.id
      end

      context "not logged in" do

        it "should redirect to the log in page" do
          post :demote_admin, id: @admin.id
          expect(response).to redirect_to my_login_path
        end

        it "should not change the admin" do
          expect{execute}.not_to change{@admin.reload}
        end
      end

      context "logged in as nonadmin" do
        before :each do
          controller.log_in @tamu_user
        end

        it "should redirect to the homepage" do
          execute
          expect(response).to redirect_to root_path
        end

        it "should not change the admin" do
          expect{execute}.not_to change{@admin.reload}
        end
      end

      context "logged in as admin" do
        before :each do
          controller.log_in @admin
        end

        it "should redirect to the homepage" do
          execute
          expect(response).to redirect_to root_path
        end
        it "should not change the admin" do
          expect{execute}.not_to change{@admin.reload}
        end
      end

      context "logged in as master admin" do
        before :each do
          @master_admin = FactoryGirl.create(:tamu_users, :master_admin)
          controller.log_in @master_admin
        end

        it "should redirect to the users index" do
          execute
          expect(response).to redirect_to tamu_users_path
        end
        it "should make the user not an admin" do
          execute
          expect(@admin.reload).not_to be_admin
        end

        it "can demote another master admin" do
          @other_master_admin = FactoryGirl.create(:tamu_users, :master_admin)
          post :demote_admin, id: @other_master_admin.id
          expect(response).to redirect_to tamu_users_path
          expect(@other_master_admin.reload).not_to be_admin
          expect(@other_master_admin.reload).not_to be_master_admin
        end

        it "you can't demote yourself" do
          post :demote_admin, id: @master_admin.id
          expect(response).to redirect_to tamu_users_path
          expect(@master_admin.reload).to be_admin
          expect(@master_admin.reload).to be_master_admin
        end
      end
    end

end
