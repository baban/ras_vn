# encoding: utf-8

class StreamsController < ApplicationController
  def index
    t = params[:t]
    #stream = Stream.last
    t = DateTime.parse( t )
    logger.info t
    stream = Stream.where( " created_at > ? ", t ).first
    stream = stream ? "#{stream.title}<p>Từ: #{stream.created_at.strftime('%Y/%m/%d %H:%M:%S')}<p>" : ""
    logger.info stream
    render json: { text: stream }
  end
end
