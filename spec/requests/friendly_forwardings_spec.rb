require 'spec_helper'

describe "FriendlyForwardings" do
  it "should forward to the requested page after signin" do
    user = FactoryGirl.create(:user)
    #visit edit_user_path(user)
    #The test automagically follows the redirect to the signin page
    #fill_in :email,       :with => user.email
    #fill_in :password,    :with => user.password
    #click_button
    #Test follows the redirect again, this time to the users/edit.
    #response.should render_template('users/edit')
  end

end
