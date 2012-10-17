class Search < ActiveRecord::Base

  def channels
    @channels ||= find_channels
  end
  
private

  def find_channels
    channels = Channel.order(:name)
    channels = channels.where("name like ?", "%#{keywords}%") if keywords.present?
    channels = channels.where("channel_type like ?", "%#{channel_type}%") if channel_type.present?
    channels = channels.where("tags like ?", "%#{tags}%") if tags.present?
    channels = channels.where("categories like ?", "%#{categories}%") if categories.present?
    channels = channels.where("language like ?", "%#{language}%") if language.present?

    #channels = channels.where(category_id: category_id) if category_id.present?
    #channels = channels.where("price >= ?", min_price) if min_price.present?
    #channels = channels.where("price <= ?", max_price) if max_price.present?
    channels
  end

end
