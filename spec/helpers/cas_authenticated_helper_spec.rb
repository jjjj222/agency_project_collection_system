require 'rails_helper'

describe CasAuthenticatedHelper do
  describe "fix_cas_session" do
    it "makes symbolized versions of keys avaiable in session[:cas]" do
      session[:cas] = { "user" => "bob" }
      helper.fix_cas_session
      expect(session[:cas]).to have_key(:user)
    end
  end

  describe "cas_logged_in?" do
    it "should return false if no cas in session" do
      expect(helper).not_to be_cas_logged_in
    end

    context "there is a :cas in session" do
      before :each do
        session[:cas] = Hash.new
      end

      it "should return false if there is nothing in :cas" do
        expect(helper).not_to be_cas_logged_in
      end
      it "should return true if there is :user in :cas" do
        session[:cas][:user] = "bob"
        expect(helper).to be_cas_logged_in
      end
      it "should return true if there is string user in :cas" do
        session[:cas]["user"] = "bob"
        expect(helper).to be_cas_logged_in
      end
    end

  end

end
