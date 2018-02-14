class SearchTopicListItemSerializer < ListableTopicSerializer
  attributes :tags,
    :category_id

  def include_tags?
    SiteSetting.tagging_enabled && (!object.private_message? || scope.user&.staff?)
  end

  def tags
    object.tags.map(&:name)
  end
end
