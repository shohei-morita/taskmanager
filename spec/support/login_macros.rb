module LoginMacros
  def login_as(user)
    visit new_session_path
    fill_in 'session-email', with: user.email
    fill_in 'session-pw', with: '0000000'
    click_on 'session-login'
  end
end
