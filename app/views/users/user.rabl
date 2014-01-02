object @user
attributes :id, :name, :email
attributes daily_limit: :dailyLimit,
           interface_language: :interfaceLanguage

node(:createdToday) { created_today_by @user }
