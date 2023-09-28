require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'have link add a client' do
    visit(root_path)
    expect(page).to have_link('Clients')
  end

  scenario 'have link new client' do
    visit(root_path)
    click_on('Clients')
    expect(page).to have_content("Client's list")
    expect(page).to have_link('Add a client')
  end

  scenario 'have a form for new client' do
    visit(customers_path)
    click_on('Add a client')
    expect(page).to have_content('New client')
    expect(page).to have_link('Save')
  end
end
