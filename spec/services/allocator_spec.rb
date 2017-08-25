require 'rails_helper'

RSpec.describe Allocator do
  let!(:array_of_users){ [{'id' => '1', 'name' => 'ollie'}, {'id' => '2', 'name' => 'iona'}, {'id' => '3', 'name' => 'foo'}, {'id' => '4', 'name' => 'bar'}] }

  it 'Adds a recipient to each user - users can only be a recipient once each, and cannot give to themselves' do
    10.times do
      response = described_class.perform(array_of_users)[:content]

      recipients_are_uniqe = response.map{ |user| user['recipient'] }.uniq.length == array_of_users.length
      expect(recipients_are_uniqe).to eq true

      recipient_is_same_as_giver = response.any?{ |user| user['recipient'] == user['name']}
      expect(recipient_is_same_as_giver).to eq false
    end
  end

end
