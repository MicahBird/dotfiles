# List of package IDs
package_ids = [
    "Git.Git",
    "LibreWolf.LibreWolf",
    "Mozilla.Firefox",
    "Microsoft.PowerToys",
    "Microsoft.VisualStudioCode",
    "lars-berger.GlazeWM",
    "twpayne.chezmoi",
    "Alacritty.Alacritty",
    "eloston.ungoogled-chromium",
    "Neovim.Neovim",
    "LocalSend.LocalSend",
]

# Template for YAML configuration
yaml_template = """
    - resource: Microsoft.WinGet.DSC/WinGetPackage
      id: {id}
      directives:
        description: Install {id}
      settings:
        id: {id}
        source: winget
"""

start_file = """# yaml-language-server: $schema=https://aka.ms/configuration-dsc-schema/0.2

properties:
  resources:
"""
end_file = """
  configurationVersion: 0.2.0
"""

# Generate YAML for each package ID
print(start_file, end='')
for package_id in package_ids:
    yaml_output = yaml_template.format(id=package_id)
    print(yaml_output, end='')
print(end_file, end='')