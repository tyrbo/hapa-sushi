module LinkHelper
  def classes_for(path:, matcher: nil, children: false)
    matcher = matcher || path
    puts matcher
    classes = ['menu-item', 'menu-item-type-custom', 'menu-item-object-custom']
    classes << 'menu-item-has-children' if children
    classes << 'current_page_item' if is_active_page?(matcher)
    classes.join(' ')
  end

  def is_active_page?(path)
    return true if path == request.path
    base_request = request.path.split('/')[1]
    base_path = path.split('/')[1]
    base_request == base_path
  end
end
