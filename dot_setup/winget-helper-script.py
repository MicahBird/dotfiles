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

# Generate YAML for each package ID
for package_id in package_ids:
    yaml_output = yaml_template.format(id=package_id)
    print(yaml_output, end='')