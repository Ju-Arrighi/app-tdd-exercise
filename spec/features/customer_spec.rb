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
  end

  scenario 'have content in form and save' do
    visit(new_customer_path)
    customer_name = Faker::Name.name
    fill_in('Name', with: customer_name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Telephone', with: Faker::PhoneNumber.phone_number)
    attach_file('Avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: %w[S N].sample)
    click_on('Save')
    # expect(page).to have_link('Save')
    expect(Customer.last.name).to eq(customer_name)
    expect(page).to have_content('Saved new client successfully')
  end
  scenario "don't save invalid content" do
    visit(new_customer_path)
    click_on('Save')
    expect(page).to have_content("Name can't be blank")
  end
  scenario 'show a client' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      telephone: Faker::PhoneNumber.phone_number
    )
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
  end
end
