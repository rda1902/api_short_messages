module UserQueries
  extend ActiveSupport::Concern

  module ClassMethods
    def top_by_count_of_messages(dates = {}, limit = 5)
      default_dates = { start: Time.now - 1.year, end: Time.now + 1.year }.merge(dates)
      query = User.select('users.*, count(messages.id) as messages_count').joins(:messages)
      query = query.group('users.id').order('messages_count desc')
      query.where('messages.created_at BETWEEN ? AND ?', default_dates[:start], default_dates[:end]).limit(limit)
    end

    def top_by_average_message_rating(dates = {}, limit = 5)
      default_dates = { start: Time.now - 1.year, end: Time.now + 1.year }.merge(dates)
      sql = <<-SQL
        With ResultSet As
        (Select Messages.user_id, Messages.id as message_id,
        Count(Votes.id) as votes_count
        from Messages
        Left Join Votes On Messages.id = Votes.message_id
        Left Join Users On Messages.user_id = Users.id
        WHERE Votes.created_at BETWEEN '#{default_dates[:start].strftime('%F')}' AND '#{default_dates[:end].strftime('%F')}'
        Group By Messages.id
        Order By votes_count desc)

        Select user_id as id, Count(message_id) as count_of_massages,
        Round(AVG(votes_count), 3) as avg_votes_count
        From ResultSet
        Group By user_id
        Order By avg_votes_count desc
        limit #{limit}
      SQL
      User.find_by_sql(sql).map do |row|
        { average_messages_rating: row['avg_votes_count'],
          user: row.reload }
      end
    end

    def top_by_vote_of_messages(dates = {}, limit = 5)
      default_dates = { start: Time.now - 1.year, end: Time.now + 1.year }.merge(dates)
      sql = <<-SQL
        Select Users.id as id, t1.votes_count, t1.message_id
        from Users
        Left join
        	(Select distinct on (Messages.user_id) Messages.user_id, Messages.id as message_id,
        	Count(Votes.id) as votes_count
        	from Messages
        	Left Join Votes On Messages.id = Votes.message_id
        	Left Join Users On Messages.user_id = Users.id
          WHERE Votes.created_at BETWEEN '#{default_dates[:start].strftime('%F')}' AND '#{default_dates[:end].strftime('%F')}'
        	Group By Messages.id
        	Order By Messages.user_id, votes_count desc) t1
        on Users.id = t1.user_id
        where votes_count is not null
        Order By votes_count desc
        Limit #{limit}
      SQL
      User.find_by_sql(sql).map do |row|
        { message_votes_count: row['votes_count'],
          message: Message.find_by(id: row['message_id']),
          user: row.reload }
      end
    end
  end
end
