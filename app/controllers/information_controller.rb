# encoding: utf-8

class InformationController < ApplicationController
  include ListedContentsHelper
  # アクションの処理はここの中で共通化
  include ControllerModule::ListedContents
end
