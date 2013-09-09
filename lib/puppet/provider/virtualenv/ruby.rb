
Puppet::Type.type(:virtualenv).provide(:ruby) do

  commands :virtenvbin => "virtualenv",
           :rm => "rm"


  def exists?

    output = %x(source #{resource[:name]}./virtualenv/bin/activate; python -c "import os; value = 'nil' if not os.environ.has_key('VIRTUAL_ENV') else os.environ['VIRTUAL_ENV']; print value")
    if output == 'nil'
      return false
    end

  end

  def create

    parameters = []
    parameters.push("-p #{resource[:version]}")
    parameters.push("--system-site-packages") unless resource[:systempkgs] == false
    parameters.push("--distribute") unless resource[:distribute] == false

    virtenvbin(parameters.join(' '), resource[:name])

  end

  def destroy
    rm('-R', "#{resource[:name]}/.virtualenv")
  end

  # Manage properties
  def version
    version = %x(source #{resource[:name]}./virtualenv/bin/activate; python -V)
  end

end