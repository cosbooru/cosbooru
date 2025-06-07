# frozen_string_literal: true

class PoolVersionsController < ApplicationController
  respond_to :html, :xml, :json

  def index
    set_version_comparison
    @pool_versions = authorize PoolVersion.paginated_search(params)
    @pool_versions = @pool_versions.includes(:updater, :pool) if request.format.html?

    respond_with(@pool_versions)
  end

  def search
    authorize PoolVersion
  end

  def diff
    @pool_version = authorize PoolVersion.find(params[:id])

    if params[:other_id]
      @other_version = PoolVersion.find(params[:other_id])
    else
      set_version_comparison
      @other_version = @pool_version.send(params[:type])
    end
  end
end
