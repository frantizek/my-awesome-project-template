import my_awesome_project_template
from my_awesome_project_template.main import main


def test_main(capsys: object) -> None:
    main()


def test_package_exports() -> None:
    assert hasattr(my_awesome_project_template, "main")
    assert callable(my_awesome_project_template.main)
