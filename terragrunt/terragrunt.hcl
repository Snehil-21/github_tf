terraform {
    source = "..//terraform"
}

inputs = {
    organization_name = "tf-test-Snehil21"

    team_name = "cit"

    admin = {
        repos = [
            "repo-1"
        ]
        teams = [
            "cit-1"
        ]
        users = [
            "varun-charan"
        ]
    }

    readonly = {
        repos = [
            "repo-2",
            "repo-3"
        ]
        teams = [
            "cit-2",
            "cit-3"
        ]
        users = []
    }

    readwrite = {
        repos = [
            "repo-4",
            "repo-5"
        ]
        teams = [
            "cit-4",
            "cit-5"
        ]
        users = [
            "varun-charan"
        ]
    }
}