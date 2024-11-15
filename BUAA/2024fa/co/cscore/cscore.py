from playwright.sync_api import Playwright, sync_playwright, TimeoutError

stu_id = ""
stu_pwd = ""

def run(playwright: Playwright) -> None:
    with open("res.out", 'a') as file:
        browser = playwright.chromium.launch(headless=False)
        context = browser.new_context()
        page = context.new_page()
        page.goto("http://cscore.buaa.edu.cn/#/login")
        page.get_by_label("用户").click()
        page.get_by_label("用户").fill(stu_id)
        page.get_by_label("用户").press("Tab")
        page.get_by_label("密码", exact=True).fill(stu_pwd)
        page.get_by_role("button", name="登录", exact=True).click()
        for problemid in range(0, 9999):
            url = "http://cscore.buaa.edu.cn/#/problem?ProblemId={}&PieId=1222".format(problemid)
            page.goto(url, wait_until="networkidle")
            try:
                page.locator("#inspire > div > main > div > div > div > div.title-div > span.text--disabled").click(timeout=200)
            except:
                continue
            page.wait_for_timeout(500)
            text = page.locator("#inspire > div > main > div > div > div > div.title-div > h2").all_text_contents()[0].strip() + " " + url
            print(text)
            file.write(text + "\n")
        # ---------------------
        context.close()
        browser.close()


with sync_playwright() as playwright:
    run(playwright)
