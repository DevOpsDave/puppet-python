Puppet::Type.newtype(:virtualenv) do

  @doc = "Manages python virtual environments."
=begin

  $ensure       = present,
  $version      = 'system',
  $requirements = false,
  $proxy        = false,
  $systempkgs   = false,
  $distribute   = true,
  $owner        = 'root',
  $group        = 'root',
  $index        = false,

=end

  ensurable do
    defaultvalues
    defaultto :present
  end

  def self.title_patterns
    [ [ /^(.*?)\/*\Z/m, [ [ :path ] ] ] ]
  end

  newparam(:path) do
    desc <<-'EOT'
      The path to the file to manage. Must be fully qualified.

      On Windows, the path should include the drive letter and should use `/` as
      the separator character (rather than `\\`).
    EOT
    isnamevar

    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end

    munge do |value|
      ::File.expand_path(value)
    end
  end

  newproperty(:version) do
    defaultto :system

    newvalues(/^system$/, /^\d+$/, /^python\d+$/)

    munge do |value|
      interpreter = ''
      case (value)
        when 'system'
          interpreter = %x(which python)
        when /^(\d+)$/
          interpreter = %x(which python#{value})
        when /^python\d+$/
          interpreter = %x(which #{value})
        else
          fail Puppet::Error, "Problem! Can not catch value #{value}"
      end
      interpreter
    end

  end

  newparam(:requirements) do
    defaultto :false
    validate do |value|
      unless value == 'false' or Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "requirements can only be false or an absolute path.  Not #{value}."
      end
    end

  end

  newparam(:proxy) do
    defaultto :false
    newvalues(/http?:\/\//, /https?:\/\//, /^false$/)
  end

  newparam(:systempkgs) do
    defaultto :false
    newvalues(:false, :true)
  end

  newparam(:disribute) do
    defaultto :true
    newvalues(:false, :true)

  end

  newproperty(:owner) do
    defaultto :root
  end

  newproperty(:group) do
    defaultto :root
  end

  neparam(:index) do
    defaultto :false
    newvalues(/http?:\/\//, /https?:\/\//, /^false$/)
  end

  # Autorequire the file resource if it's being managed
  autorequire(:file) do
    req = []
    path = Pathname.new(self[:path])
    if !path.root?
      # Start at our parent, to avoid autorequiring ourself
      parents = path.parent.enum_for(:ascend)
      if found = parents.find { |p| catalog.resource(:file, p.to_s) }
        req << found.to_s
      end
    end
    # if the resource is a link, make sure the target is created first
    #req << self[:target] if self[:target]
    req
  end

  # Autorequire the owner and group of the file.
  {:user => :owner, :group => :group}.each do |type, property|
    autorequire(type) do
      if @parameters.include?(property)
        # The user/group property automatically converts to IDs
        next unless should = @parameters[property].shouldorig
        val = should[0]
        if val.is_a?(Integer) or val =~ /^\d+$/
          nil
        else
          val
        end
      end
    end
  end

end
