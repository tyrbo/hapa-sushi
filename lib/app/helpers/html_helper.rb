module HTMLHelper
  def html_safe(text)
    Rack::Utils.escape_html(text)
  end
end
