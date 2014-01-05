object @user
attributes :id, :name, :email
attributes daily_limit: :dailyLimit,
           interface_language: :interfaceLanguage

node(:createdToday) { created_today_by @user }
node(:runToday) { run_today_by @user }
node(:plannedForToday) { planned_for_today_by @user }
