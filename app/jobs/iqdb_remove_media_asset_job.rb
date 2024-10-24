# frozen_string_literal: true

# A job that removes a media asset from IQDB when it is deleted. Spawned by the {MediaAsset}.
# class.
class IqdbRemoveMediaAssetJob < ApplicationJob
  def perform(media_asset_id)
    IqdbClient.new.remove(media_asset_id)
  end
end
