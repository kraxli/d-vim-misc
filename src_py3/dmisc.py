
import os
import re
from itertools import chain


def get_dub_import_paths(dub_path, std_imports = True):
    """
    get dub import paths of latest dub packages

    :dub_path: str; path to dub-directory
    :std_imports: list of str or boolean; std import paths. If set to None/True defaults are used (defaults see below). If False, no std import paths are added
    :return: list; import paths
    """

    default_import_paths = ['/usr/include/dmd',
                            '/usr/include/dmd/phobos',
                            '/usr/include/dmd/druntime/import']

    std_imports = default_import_paths if (std_imports is None or std_imports) else std_imports

    dub_directories = os.listdir(dub_path)
    package_registry = {}

    # TODO: construct generator
    for package in dub_directories:
        if (package is None) or (type(package) is not str):
            continue

        split_position = re.search("-\d", package).start()
        package_name = package[:split_position]
        package_version = package[split_position+1:]
        if package_name not in package_registry.keys():
            package_registry.update({package_name: [package_version]})
        else:
            package_registry[package_name].append(package_version)
            package_registry[package_name].sort(reverse=True)

    packages_latest = (pack + "-" + rel[0]  for pack, rel in package_registry.items())

    source = lambda pack: os.path.join(dub_path, pack, 'source')
    parent =  lambda pack: os.path.join(dub_path, pack)
    import_paths = list(chain.from_iterable((parent(p), source(p)) for p in packages_latest))

    return std_imports + import_paths

def generate_config_files(dub_path, std_imports = None):
    import_path_list = get_dub_import_paths(dub_path, std_imports)





# dub_path =  r'/home/dave/.dub/packages/'
# get_dub_import_paths(dub_path)

