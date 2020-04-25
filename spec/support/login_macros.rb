# frozen_string_literal: true

module LoginMacros
  def act_as(user)
    login user
    yield
    logout
  end

  def login(user)
    visit new_session_path
    fill_in 'session[email]', with: user.email.to_s
    fill_in 'session[password]', with: user.password.to_s
    click_on 'commit'
    expect(page).to have_content 'ログインしました'
  end

  def logout
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end
end
