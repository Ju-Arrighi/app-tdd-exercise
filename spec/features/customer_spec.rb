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
  scenario 'list clients on index page' do
    customer1 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      telephone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoke: %w[S N].sample
    )
    customer2 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      telephone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoke: %w[S N].sample
    )
    visit(customers_path)
    expect(page).to have_content(customer1.name)
    expect(page).to have_content(customer2.name)
  end
  scenario 'edit a customer' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      telephone: Faker::PhoneNumber.phone_number
    )
    new_name = Faker::Name.name
    visit(edit_customer_path(customer.id))
    fill_in('Name', with: new_name)
    click_on('Update')
    expect(page).to have_content(new_name)
    expect(page).to have_content('Client updated successfully')
  end
  scenario 'click on show link at index' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      telephone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoke: %w[S N].sample
    )
    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[2]/a').click
    expect(page).to have_content('Client Data')
  end
  scenario 'click on edit link at index' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      telephone: Faker::PhoneNumber.phone_number,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png",
      smoke: %w[S N].sample
    )
    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[3]/a').click
    expect(page).to have_content('Edit Client')
  end
end
