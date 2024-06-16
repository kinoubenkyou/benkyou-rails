require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    params = { code: "code", name: "name" }
    post organizations_url, as: :json, params: params
    assert_equal response.status, 201
    body = JSON.parse(response.body)
    assert_includes body.keys, "id"
    assert Organization.exists?(**params)
  end

  test "create_with_errors" do
    params = { code: "code1", name: "name" }
    post organizations_url, as: :json, params: params
    assert_equal response.status, 400
    body = JSON.parse(response.body)
    assert_not_empty body
  end

  test "destroy" do
    delete organization_url(1), as: :json
    assert_equal response.status, 204
    assert_not Organization.exists?(id: 1)
  end

  test "index" do
    query = { order: "code", page: 2, per: 1 }
    get organizations_url(**query), as: :json
    assert_equal response.status, 200
    body = JSON.parse(response.body)
    assert_equal body.length, 1
    assert_equal body.first["id"], 2
  end

  test "index_with_code_search" do
    query = { code_search: "2" }
    get organizations_url(**query), as: :json
    assert_equal response.status, 200
    body = JSON.parse(response.body)
    assert_equal body.length, 1
    assert_equal body.first["id"], 2
  end

  test "index_with_name_search" do
    query = { name_search: "2" }
    get organizations_url(**query), as: :json
    assert_equal response.status, 200
    body = JSON.parse(response.body)
    assert_equal body.length, 1
    assert_equal body.first["id"], 2
  end

  test "show" do
    get organization_url(1), as: :json
    assert_equal response.status, 200
    body = JSON.parse(response.body)
    assert_equal body["id"], 1
  end

  test "update" do
    params = { code: "code", name: "name" }
    patch organization_url(1), as: :json, params: params
    assert_equal response.status, 204
    assert Organization.exists?(id: 1, **params)
  end

  test "update_with_errors" do
    params = { code: "code2", name: "name" }
    patch organization_url(1), as: :json, params: params
    assert_equal response.status, 400
    body = JSON.parse(response.body)
    assert_not_empty body
  end
end
