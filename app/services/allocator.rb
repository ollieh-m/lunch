class Allocator

  def self.perform(array_of_users)
    shuffled_array_of_users = array_of_users.shuffle
    shuffled_array_of_users_offset_one_position = shuffled_array_of_users.rotate

    users_with_recipients = []

    shuffled_array_of_users.each_with_index do |user, index|
      user_with_recipient = user.merge({'recipient' => shuffled_array_of_users_offset_one_position[index]['name']})
      users_with_recipients << user_with_recipient
    end

    {success: true, content: users_with_recipients}
  end

end
