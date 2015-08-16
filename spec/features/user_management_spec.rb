feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, fadi@example.com')
    expect(User.first.email).to eq('fadi@example.com')
  end

  def sign_up(email: 'fadi@example.com',
              name: 'fadi',
              username: 'fadi',
              password: '12345678',
              password_confirmation: '12345678')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    fill_in :name,    with: name
    fill_in :username, with: username
    click_button 'Sign up'
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'without an email' do
    expect {sign_up(email: '')}.not_to change(User, :count)
    expect(current_path).to eq('/users')
  end
end