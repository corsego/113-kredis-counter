class CounterController < ApplicationController
  before_action :counter

  def show
  end

  def increment
    counter.increment
    # http_stream_counter
    websockets_stream_counter
  end

  def decrement
    counter.decrement
    # http_stream_counter
    websockets_stream_counter
  end

  private 

  def counter
    @counter ||= Kredis.counter 'mycounter'
  end

  def http_stream_counter
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('counter', html: counter.value)
      end
    end
  end

  def websockets_stream_counter
    Turbo::StreamsChannel.broadcast_update_to('counter_stream', target: 'counter', html: counter.value)
  end
end
