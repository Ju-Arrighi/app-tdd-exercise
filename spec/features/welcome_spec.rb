require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  scenario 'show welcome massage at root page' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
  scenario 'verify link Clients' do
    visit(root_path)
    # expect(page).to have_selector('ul li')
    # expect(page).to have_link('Add a client')
    expect(page.find('ul li')).to have_link('Clients')
  end
end
