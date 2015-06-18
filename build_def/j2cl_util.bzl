"""Utility functions for the j2cl_* build rules / macros"""


def _get_java_root_index(pkg_name):
  """Returns the index of the java_root within a build package"""
  # Find the java folder in the beginning, middle or end of a path.
  if pkg_name.endswith("java"):
    java_index = pkg_name.rfind("java")
  else:
    java_index = pkg_name.rfind("java/")

  # Find the javatests folder in the beginning, middle or end of a path.
  if pkg_name.endswith("javatests"):
    javatests_index = pkg_name.rfind("javatests")
  else:
    javatests_index = pkg_name.rfind("javatests/")

  if java_index == -1 and javatests_index == -1:
    fail("can not find java root")

  if java_index > javatests_index:
    index = java_index + len("java/")
  else:
    index = javatests_index + len("javatests/")
  return index


def get_java_root(pkg_name):
  """Extract the path to java root from the build package"""
  return pkg_name[:_get_java_root_index(pkg_name)]


def get_java_package(pkg_name):
  """Extract the java package from the build package"""
  return pkg_name[len(get_java_root(pkg_name)):].replace("/", ".")
