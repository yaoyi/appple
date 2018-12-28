# frozen_string_literal: true

# Modified from
# http://phansch.net/2017/02/12/a-better-pry-prompt-for-rails-console/

if defined?(::Pry)
  # awesome_print
  begin
    require "awesome_print"

    AwesomePrint.pry!
    AwesomePrint.defaults = {
      indent: 2,
    }
  rescue LoadError
    # The gem could be missing
  end


  # better_errors
  # Should be already required in Gemfile, if present
  if defined?(::BetterErrors)
    BetterErrors.editor = :subl
    # BetterErrors.use_pry!
  end


  # Better prompt
  def formatted_env
    case Rails.env
    when "production"
      bold_upcased_env = Pry::Helpers::Text.bold(Rails.env.upcase)
      Pry::Helpers::Text.red(bold_upcased_env)
    when "staging"
      Pry::Helpers::Text.yellow(Rails.env)
    when "development"
      Pry::Helpers::Text.green(Rails.env)
    else
      Pry::Helpers::Text.magenta(Rails.env)
    end
  end

  def formatted_app_name
    Pry::Helpers::Text.cyan(
      Rails.application.class.parent_name,
    )
  end

  if defined?(::Rails)
    Pry.config.pager = false
    Pry.config.prompt = proc do |obj, nest_level, pry|
      [
        "[#{formatted_app_name}][#{formatted_env}]",
        "[#{pry.input_array.size}]",
        "#{obj}:#{nest_level} > ",
      ].join(" ")
    end
  end
end
