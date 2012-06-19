# encoding: utf-8
#
module Kernel
  def ∞
    Float::INFINITY
  end
end

class Object
  def do(*args,&b)
    yield self, *args
  end
end

