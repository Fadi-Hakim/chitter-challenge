feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    user = build :user
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, fadi@example.com')
    expect(User.first.email).to eq('fadi@example.com')
  end

  def sign_up(user)
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    fill_in :name,    with: user.name
    fill_in :username, with: user.username
    click_button 'Sign up'
  end

  scenario 'requires a matching confirmation password' do
    user = create :user, password_confirmation: 'wrong'
    expect { sign_up(user) }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    user = create :user, password_confirmation: 'wrong'
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'without an email' do
    user = create :user, email: ''
    expect {sign_up(user)}.not_to change(User, :count)
    expect(current_path).to eq('/users')
  end
end
