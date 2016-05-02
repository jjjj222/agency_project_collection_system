require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    def sorted_by(list, method)
      list.each_cons(2).all? {|a,b| a.send(method) <=> b.send(method) }
    end
    def reverse_sorted_by(list, method)
      sorted_by list.reverse, method
    end

    describe "GET #index" do
      
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in(@tamu_user)
        end
      
        it "populates an array of projects if logged in as tamu user" do
            project = FactoryGirl.create(:project, :default, :approved)
            get :index
            expect(assigns(:projects)).to eq([project])
        end

        context "asked to sort" do
          before :each do
            a1 = FactoryGirl.create(:agency, :default, :approved, name: "A")
            a2 = FactoryGirl.create(:agency, :default, :approved, name: "Z")
            p1 = FactoryGirl.create(:project, :default, :approved, name: "Z", agency: a1)
            p2 = FactoryGirl.create(:project, :default, :approved, :old, name: "A", agency: a2)
            FactoryGirl.create_list(:projects, 10).each do |proj|
              proj.agency = proj.id.even? ? a1 : a2
              proj.save
            end
          end
          it "can sort projects by name" do
              get :index, sort: :name
              expect(sorted_by(assigns(:projects), :name))
          end
          it "can sort projects by date" do
              get :index, sort: :date
              expect(sorted_by(assigns(:projects), :created_at))
          end
          it "can sort projects by agency" do
              get :index, sort: :agency
              expect(sorted_by(assigns(:projects), :agency))
          end

          context "in reverse order" do
          it "can sort projects by name" do
              get :index, sort: :name, reverse: true
              expect(reverse_sorted_by(assigns(:projects), :name))
          end
          it "can sort projects by date" do
              get :index, sort: :date, reverse: true
              expect(reverse_sorted_by(assigns(:projects), :created_at))
          end
          it "can sort projects by agency" do
              get :index, sort: :agency, reverse: true
              expect(reverse_sorted_by(assigns(:projects), :agency))
          end
          end
        end

        context "filter results" do
          context "search by project name" do
            before :each do
              @project_1 = FactoryGirl.create(:project, :default, :approved, name: "full name" )
              @project_2 = FactoryGirl.create(:project, :default, :approved, name: "other name")
              @type = "name"
            end

            it "can search full name" do
              value = "full name"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_1
            end

            it "can search partial name" do
              value = "other"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_2
            end

            it "is case insensitive" do
              value = "NAME"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 2
            end
          end

          context "search by agency name" do
            before :each do
              @agency_1 = FactoryGirl.create(:agency, :default, :approved, name: "first last")
              @agency_2 = FactoryGirl.create(:agency, :default, :approved, name: "middle last")
              FactoryGirl.create(:project, :default, :approved, agency: @agency_1)
              FactoryGirl.create(:project, :default, :approved, agency: @agency_2)
              @type = "agency_name"
            end

            it "can search full name" do
              value = "first last"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0].agency).to eq @agency_1
            end

            it "can search partial name" do
              value = "middle"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0].agency).to eq @agency_2
            end

            it "is case insensitive" do
              value = "LasT"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 2
            end
          end

          context "search by description" do
            before :each do
              @project_1 = FactoryGirl.create(:project, :default, :approved, description: "some description" )
              @project_2 = FactoryGirl.create(:project, :default, :approved, description: "other description")
              @type = "description"
            end

            it "can search full descrioption" do
              value = "some description"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_1
            end

            it "can search partial description" do
              value = "other"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_2
            end

            it "is case insensitive" do
              value = "DesCrip"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 2
            end
          end

          context "search by status" do
            before :each do
              @project_1 = FactoryGirl.create(:project, :default, :approved, status: "unapproved_completed" )
              @project_2 = FactoryGirl.create(:project, :default, :approved, status: "open")
              @type = "status"
            end

            it "can search full status" do
              value = "unapproved_completed"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_1
            end

            it "can search partial status" do
              value = "op"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_2
            end

            it "is case insensitive" do
              value = "unapproved_completed"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_1
            end
          end

          context "search by tags" do
            before :each do
              @project_1 = FactoryGirl.create(:project, :default, :approved, tags: ['abc', 'def'])
              @project_2 = FactoryGirl.create(:project, :default, :approved, tags: ['ABC'])
              @type = "tags"
            end

            it "can search full tag" do
              value = "def"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 1
              expect(assigns(:projects)[0]).to eq @project_1
            end

            it "can search partial tag" do
              value = "ab"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 2
            end

            it "is case insensitive" do
              value = "ABC"
              get :index, search: {'value' => value, 'type' => @type}

              expect(assigns(:projects).length).to be 2
            end
          end

        end

        
        it "renders the :index view if logged in as tamu user" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            expect(response).to render_template :index
        end
        
        it "populates an array of projects if logged in" do
            controller.log_out
            project = FactoryGirl.create(:project, :default, :approved)
            get :index
            expect(assigns(:projects)).to_not eq([project])
        end
        
        it "renders the :index view if logged in" do
            controller.log_out
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
    
    describe "GET #unapproved index" do
        
        before :each do
          @admin = FactoryGirl.create(:tamu_user, :default, :admin)
          controller.log_in(@admin)
        end
      
        it "populates an array of projects if logged in as admin" do
            project = FactoryGirl.create(:project, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:projects)).to eq([project])
        end
        
        it "renders the unapproved index view if logged in as admin" do
            get :unapproved_index
            expect(response).to render_template :unapproved_index
        end
        
        it "populates an array of projects if not logged in as admin" do
            controller.log_out
            project = FactoryGirl.create(:project, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:projects)).to_not eq([project])
        end
        
        it "renders the unapproved index view if not logged in as admin" do
            controller.log_out
            get :unapproved_index
            expect(response).to_not render_template :unapproved_index
        end
        
        it "redirects to root path if not admin" do
            controller.current_user.admin = false
            get :unapproved_index
            expect(response).to redirect_to root_path
        end
        
    end
    
    describe "GET #show" do
      
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in(@tamu_user)
        end
      
        it "assigns the requested project to @project if logged in as a tamu user" do
            project = FactoryGirl.create(:project, :default)
            get :show, id: project
            expect(assigns(:project)).to eq(project)
        end
        
        
        it "it renders the :show view if logged in as tamu user" do
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to render_template :show
        end
        
        it "does not assign the requested project to @project if not logged in" do
            controller.log_out
            project = FactoryGirl.create(:project, :default)
            get :show, id: project
            expect(assigns(:project)).to_not eq(project)
        end
        
        
        it "it does not render the :show view if not logged in" do
            controller.log_out
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to_not render_template :show
        end
        
        it "it renders :projects if not admin trying to view unapproved project" do
            controller.log_out
            @tamu_user_not_admin = FactoryGirl.create(:tamu_user, :default, :not_admin)
            controller.log_in(@tamu_user_not_admin)
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to redirect_to projects_path
        end
        
        it "redirects to root path if not tamu_user and does not own projects" do
          controller.log_out
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
          get :show, id: FactoryGirl.create(:project, :default)
          expect(response).to redirect_to root_path
        end
        
    end
    
    describe "GET #edit" do
      
        before :each do
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
        end
      
        it "assigns the requested project to @project if logged in as the owning agency" do
            project = FactoryGirl.create(:project, :default, agency: @agency)
            get :edit, id: project
            expect(assigns(:project)).to eq(project)
        end


        it "it renders the :edit view if logged in as the owning agency" do
            @project = FactoryGirl.create(:project, :default, :agency => @agency)
            get :edit, id: @project
            expect(response).to render_template :edit
        end

        it "does not assign the requested project to @project if not logged in" do
            controller.log_out
            project = FactoryGirl.create(:project, :default)
            get :edit, id: project
            expect(assigns(:project)).to_not eq(project)
        end

        it "it does not render the :edit view if not logged in" do
            controller.log_out
            @project = FactoryGirl.create(:project, :default, :agency => @agency)
            get :edit, id: @project
            expect(response).to_not render_template :edit
        end

        it "does not assign the requested project to @project if not logged in as the owning agency" do
            other_agency = FactoryGirl.create(:agency, :updated, :email)
            project = FactoryGirl.create(:project, :default, agency: other_agency)
            get :edit, id: project
            expect(assigns(:project)).to_not eq(project)
        end


        it "it does not render the :edit view if not logged in as the owning agency" do
            other_agency = FactoryGirl.create(:agency, :updated, :email)
            project = FactoryGirl.create(:project, :default, agency: other_agency)
            get :edit, id: project
            expect(response).to_not render_template :edit
        end
    end

    describe "GET #new" do
      
        before :each do
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
        end
      
        it "makes a new project if logged in as an agency" do
            get :new
            expect(assigns(:project)).to be_a_new(Project)
        end

        it "it renders the :new view if logged in as an agency" do
            get :new
            expect(response).to render_template :new
        end
        
        it "does not create a new project if not logged in as an agency" do
            controller.log_out
            get :new
            expect(assigns(:project)).to_not be_a_new(Project)
        end

        it "it does not render the :new view if not logged in as an agency" do
            controller.log_out
            get :new
            expect(response).to_not render_template :new
        end
    end
    
    describe "POST create" do
      
      before :each do
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
      end
      
      context "with valid attributes and logged in as agency" do
        it "creates a new project" do
          expect{
            post :create, project: FactoryGirl.attributes_for(:project, :default)
          }.to change(Project,:count).by(1)
        end
        
        it "redirects to the new project" do
          post :create, project: FactoryGirl.attributes_for(:project, :default)
          expect(response).to redirect_to Project.last
        end
      end
      
       context "with invalid attributes" do
        it "does not save the new contact" do
          expect{
            post :create, project: FactoryGirl.attributes_for(:project, :invalid)
          }.to_not change(Project,:count)
        end
        
        it "re-renders the new method" do
          post :create, project: FactoryGirl.attributes_for(:project, :invalid)
        end
      end
      
      context "with valid attributes but not logged in" do
        it "creates a new project" do
          controller.log_out
          expect{
            post :create, project: FactoryGirl.attributes_for(:project, :default)
          }.to change(Project,:count).by(0)
        end
        
        it "redirects to the new project" do
          controller.log_out
          post :create, project: FactoryGirl.attributes_for(:project, :default)
          expect(response).to_not redirect_to Project.last
        end
      end
    end
    
    describe 'PUT update' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        controller.log_in(@agency)
        @project = FactoryGirl.create(:project, :default, :agency => @agency)
      end
  
      context "valid attributes and logged in as agency" do
        it "located the requested @project" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
          expect(assigns(:project)).to eq(@project)
        end
  
        context  "everything goes well" do
          it "changes @project's attributes" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :updated)
            @project.reload
            expect(@project.name).to eq("Test Project updated")
            expect(@project.description).to eq("This is the test project description updated")
            expect(@project.status).to eq("unapproved_completed")
            expect(@project.tags).to eq(["updated"])
          end

          it "redirects to the updated project" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
            expect(response).to redirect_to @project
          end
        end
        context  "update fails" do
          before :each do
            expect_any_instance_of(Project).to receive(:update_attributes).and_return(nil)
          end

          it "does not change @project's attributes" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
            @project.reload
            expect(@project.name).to eq("Test Project")
            expect(@project.description).to eq("This is the test project description")
            expect(@project.status).to eq("open")
            expect(@project.tags).to eq([""])
          end
          it "re-renders the edit method" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
            expect(response).to render_template :edit
          end

        end

      end
  
      context "invalid attributes" do
        it "locates the requested @project" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          expect(assigns(:project)).to eq(@project)
        end
    
        it "does not change @project's attributes" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          @project.reload
          expect(@project.name).to eq("Test Project")
          expect(@project.description).to eq("This is the test project description")
          expect(@project.status).to eq("open")
          expect(@project.tags).to eq([""])
        end
    
        it "re-renders the edit method" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          expect(response).to render_template :edit
        end
      end
      
      context "valid attributes and not logged in as agency" do
        it "located the requested @project" do
          controller.log_out
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
          expect(assigns(:project)).to_not eq(@project)
        end
  
        context  "everything goes well" do
          it "changes @project's attributes" do
            controller.log_out
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :updated)
            @project.reload
            expect(@project.name).to_not eq("Test Project updated")
            expect(@project.description).to_not eq("This is the test project description updated")
            expect(@project.status).to_not eq("unapproved_completed")
            expect(@project.tags).to_not eq(["updated"])
          end

          it "redirects to the updated project" do
            controller.log_out
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
            expect(response).to_not redirect_to @project
          end
        end
      end
    end
    
    describe 'POST approve' do
      before :each do
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
        @project = FactoryGirl.create(:project, :default, :unapproved)
      end

      it "located the requested @project if logged in as admin" do
        post :approve, id: @project, project: FactoryGirl.attributes_for(:project, :default, :unapproved)
        expect(assigns(:project)).to eq(@project)
      end

      it "changes @project's approved field if logged in as admin" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to eq(true)
      end
      
      it "does not locate the requested @project if not logged in" do
        controller.log_out
        post :approve, id: @project, project: FactoryGirl.attributes_for(:project, :default, :unapproved)
        expect(assigns(:project)).to_not eq(@project)
      end

      it "does not change @project's approved field if not logged in" do
        controller.log_out
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to_not eq(true)
      end

      it "redirects to the approved projects if there is no unapproved projects left if logged in as admin" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to projects_path
      end
      
      it "redirects to the unapproved projects if there are unapproved projects left if logged in as admin" do
        FactoryGirl.create(:project, :default, :unapproved)
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to unapproved_projects_index_path
      end
      
      it "does not redirect to the approved projects if there is no unapproved projects left if not logged in" do
        controller.log_out
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to_not redirect_to projects_path
      end
      
      it "does not redirect to the unapproved projects if there are unapproved projects left if not logged in" do
        controller.log_out
        FactoryGirl.create(:project, :default, :unapproved)
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to_not redirect_to unapproved_projects_index_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :approve, id: @project
            expect(response).to redirect_to root_path
      end
      
    end
    
    describe 'POST unapprove' do
      before :each do
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
        @project = FactoryGirl.create(:project, :default, :approved)
      end

      it "located the requested @project if logged in" do
        post :unapprove, id: @project, project: FactoryGirl.attributes_for(:project, :default, :approved)
        expect(assigns(:project)).to eq(@project)
      end

      it "changes @project's approved field if logged in" do
        post :unapprove, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to eq(false)
      end

      it "redirects to the approved projects if logged in" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to projects_path
      end
      
      it "is not located the requested @project if not logged in" do
        controller.log_out
        post :unapprove, id: @project, project: FactoryGirl.attributes_for(:project, :default, :approved)
        expect(assigns(:project)).to_not eq(@project)
      end

      it "does not change @project's approved field if not logged in" do
        controller.log_out
        post :unapprove, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to_not eq(false)
      end

      it "does not redirect to the approved projects if not logged in" do
        controller.log_out
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to_not redirect_to projects_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :unapprove, id: @project
            expect(response).to redirect_to root_path
      end
      
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        controller.log_in(@agency)
        @project = FactoryGirl.create(:project, :default, :agency => @agency)
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        @project.tamu_users << @tamu_user
      end
      
      it "deletes the project if logged in as agency" do
        expect{
          delete :destroy, id: @project
        }.to change(Project,:count).by(-1)
      end

      it "reduces the number of projects the agency has by one" do
        expect{
          delete :destroy, id: @project
        }.to change(@agency.projects,:count).by(-1)
      end

      it "reduces the number of projects the tamu user has by one" do
        expect{
          delete :destroy, id: @project
        }.to change(@tamu_user.projects,:count).by(-1)
      end
        
      it "redirects to project#index if logged in as agency" do
        delete :destroy, id: @project
        expect(response).to redirect_to projects_path
      end
      
      it "does not delete the project if not logged in as agency" do
        controller.log_out
        expect{
          delete :destroy, id: @project
        }.to change(Project,:count).by(0)
      end
        
      it "does not redirect to project#index if not logged in as agency" do
        controller.log_out
        delete :destroy, id: @project
        expect(response).to_not redirect_to projects_path
      end
      
      it "redirects to root path if not agency" do
        controller.log_out
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        controller.log_in(@tamu_user)
        delete :destroy, id: @project
        expect(response).to redirect_to root_path
      end
      
    end

    describe "POST #join" do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        @project = FactoryGirl.create(:project, :default, :approved, agency: @agency)
      end

      it "should redirect if not logged in" do
        post :join, id: @project.id
        expect(response).to redirect_to my_login_path
      end

      it "should redirect if logged in as agency" do
        controller.log_in @agency
        post :join, id: @project.id
        expect(response).to redirect_to root_path
      end

      context "logged in as user" do
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in @tamu_user
        end

        it "should make the project show up in the user's projects" do
          post :join, id: @project.id
          expect(@tamu_user.projects).to include(@project)
        end

        it "should not be duplicated in the user's project list" do
          @tamu_user.projects << @project
          expect{post :join, id: @project.id }.not_to change(@tamu_user.projects, :count)
        end

        it "should redirect to projects page if unapproved" do
          @tamu_user.admin = false
          @project.approved = false
          @tamu_user.save
          @project.save
          post :join, id: @project.id
          expect(response).to redirect_to projects_path
        end

        it "should redirect to projects page if unapproved even if admin" do
          @project.approved = false
          @project.save
          post :join, id: @project.id
          expect(response).to redirect_to projects_path
        end

        it "should redirect to the project path if unapproved_completed" do
          @project.status = "unapproved_completed"
          @project.save
          post :join, id: @project.id
          expect(response).to redirect_to project_path(@project)
        end


      end

    end

    describe "POST #drop" do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        @project = FactoryGirl.create(:project, :default, :approved, agency: @agency)
      end

      it "should redirect if not logged in" do
        post :drop, id: @project.id
        expect(response).to redirect_to my_login_path
      end

      it "should redirect if logged in as agency" do
        controller.log_in @agency
        post :drop, id: @project.id
        expect(response).to redirect_to root_path
      end

      context "logged in as user" do
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in @tamu_user
        end

        it "should make the project not show up in the user's projects" do
          post :drop, id: @project.id
          expect(@tamu_user.projects).not_to include(@project)
        end

        it "should not reduce the number of user's projects if they aren't on it" do
          expect{post :drop, id: @project.id}.not_to change(@tamu_user.projects, :count)
        end

        it "should redirect to projects page if unapproved" do
          @tamu_user.admin = false
          @project.approved = false
          @tamu_user.save
          @project.save
          post :drop, id: @project.id
          expect(response).to redirect_to projects_path
        end

        it "should redirect to projects page if unapproved even if admin" do
          @project.approved = false
          @project.save
          post :drop, id: @project.id
          expect(response).to redirect_to projects_path
        end

        it "should redirect to the project path if unapproved_completed" do
          @project.status = "unapproved_completed"
          @project.save
          post :drop, id: @project.id
          expect(response).to redirect_to project_path(@project)
        end

        context "working on the project" do
          before :each do
            @tamu_user.projects << @project
          end

          it "should remove the project from the list of user's projects" do
            post :drop, id: @project.id
            @tamu_user.reload
            expect(@tamu_user.projects).not_to include(@project)
          end

          it "should reduce the number of user's projects by 1" do
            expect{post :drop, id: @project.id}.to change(@tamu_user.projects, :count).by(-1)
          end
        end
      end

    end
end
