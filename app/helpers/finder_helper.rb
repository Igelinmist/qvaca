module FinderHelper
  def search_link(content)
    if content.class.to_s == 'Question'
      link_to truncate(content.title, length: 80), content
    else
      link_to truncate(content.body, length: 80), content.question
    end
  end
end
