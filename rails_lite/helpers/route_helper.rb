require 'erb'

module RouteHelper

  def link_to(name, path)
    link = "<a alt=#{name} href=#{path}>#{name}</a>"
  end

  def button_to(button_text, path, options={})
    unless options[:method]
      options[:method] = "get"
    end

    button = <<-HTML
      <form action=#{path} method=#{options[:method]}>
        <input type="submit" value="button_text">
      </form>
    HTML

    button
  end
end
