# frozen_string_literal: true

# A job that adds a post to IQDB when a new media asset is uploaded, or when a media asset is
# regenerated. Spawned by the {Post} and {MediaAsset} classes.
class IqdbAddMediaAssetJob < ApplicationJob
  def perform(media_asset)
    IqdbClient.new.add_media_asset(media_asset)
  end
end
