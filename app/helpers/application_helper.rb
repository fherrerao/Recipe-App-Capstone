module ApplicationHelper
  def current_class?(test_path)
    return 'nav-link active' if request.path.include? test_path

    'nav-link'
  end
end
