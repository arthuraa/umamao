namespace :suggestions do
  desc "Remove suggestions whose suggested entry doesn't exist anymore"
  task :prune => :environment do
    Suggestion.query.each do |suggestion|
      if suggestion.entry.blank?
        suggestion.user.remove_suggestion(suggestion)
      elsif suggestion.user &&
          !suggestion.user.suggestion_list.
          topic_suggestion_ids.include?(suggestion.id) &&
          !suggestion.user.suggestion_list.user_suggestion_ids.
          include?(suggestion.id)
        suggestion.destroy
      end
    end
  end

  desc "Refreshes suggestions for all users"
  task :refresh => :environment do
    Rails.logger.info "Refreshing suggestions for users..."
    User.query.each do |user|
      user.refresh_suggestions
      user.save :validate => false
    end
  end
end
