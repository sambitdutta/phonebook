require 'resolv'
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ## Constant validations
  EMAIL_REGEX = {
    with: /\A^(?:[a-z0-9._%+-]+@)(?:(?!\d+\.)[\w\-]{1,63}\.)+(?:[a-z]{2,})$\z/i,
    message: 'must be valid email address'
  }.freeze
  MULT_EMAIL_REGEX = {
    with: /\A^(?:(?:[a-z0-9._%+-]+@)(?:(?!\d+\.)[\w\-]{1,63}\.)+(?:[a-z]{2,})(?:;\s*){0,1})+$\z/i,
    message: 'must be valid email addresses seporated by a semicolons'
  }.freeze
  HOSTNAME_REGEX = {
    with: /\A^(?:(?!\d+\.)[\w\-]{1,63}\.)+(?:[a-z]{2,})$\z/i,
    message: 'must be valid hostname'
  }.freeze
  MULT_HOSTNAME_REGEX = {
    with: /\A^(?=.*[^\s]\z)(?:(?:(?!\d+\.)[\w\-]{1,63}\.)+(?:[a-z]{2,})\s{0,1})+$\z/i,
    message: 'must be valid hostnames seporated by a space'
  }.freeze
  POSTFIX_TRANSPORT = {
    with: /\A^smtp:\[(?:(?!\d+\.)[\w\-]{1,63}\.)+(?:[a-z]{2,})\]\:\d+$\z/i,
    message: 'must be in format smtp:[hostname]:port'
  }.freeze
  ONLY_LETTERS = {
    with: /\A^[a-z]+$\z/i,
    message: 'must only contain letters'
  }.freeze
  IP_REGEX = {
    with: Resolv::IPv4::Regex,
    message: 'must be valid IP format'
  }.freeze
end
