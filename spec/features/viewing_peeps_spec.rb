feature 'Viewing links' do

  scenario 'I can see existing peeps on the peeps page' do
    Peep.create(content: "Hello World")

    visit '/peeps'
    expect(page.status_code).to eq 200
    within 'ul#peeps' do
      expect(page).to have_content('Hello World')
    end
  end
end
