require 'templates_paths'

module JsEnv
  extend ActiveSupport::Concern
  include TemplatesPaths

  included do
    helper_method :js_env
  end

  def current_user
    logged_in? ? current_user.extend(HeaderUserRepresenter).to_json : {}
  end

  def js_env
    data = {
      env: Rails.env,
      templates: templates,
      facebookId: ENV['FACEBOOK_KEY'],
      currentUser: current_user
    }

    <<-EOS.html_safe
      <script type="text/javascript">
        shared = angular.module('MealOrdering')
        shared.constant('Rails', #{data.to_json})
      </script>
    EOS
  end
end
