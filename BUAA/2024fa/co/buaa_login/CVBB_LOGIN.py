import json
import re
import requests
import time

import SRUN


class CVBB_LOGIN:
    def __init__(self, id, pwd, url="https://gw.buaa.edu.cn"):
        self.id = id
        self.pwd = pwd
        self.header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 \
                    (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 Edg/128.0.0.0'
        }
        self.url = url.strip('/')
        self.get_challenge = self.url + "/cgi-bin/get_challenge"
        self.srun_portal = self.url + "/cgi-bin/srun_portal"

    def run(self):

        if not self.id or not self.pwd:
            print("Not found id or pwd! How can you log in without them?")
            return -1

        init_res = requests.get(self.url, headers=self.header)
        ip = re.search('id="user_ip" value="(.*?)"', init_res.text).group(1)
        get_challenge_data = {
            "callback": "jQuery112401316671457983556_" + str(int(time.time() * 1000)),
            "username": self.id,
            "ip": ip,
            "": int(time.time() * 1000)
        }
        get_challenge_res = requests.get(self.get_challenge, params=get_challenge_data, headers=self.header)
        token = re.search('"challenge":"(.*?)"', get_challenge_res.text).group(1)
        info = {
            "username": self.id,
            "password": self.pwd,
            "ip": ip,
            "acid": '1',
            "enc_var": 'srun_bx1',
        }
        info = re.sub("'", '"', str(info))
        info = re.sub(" ", '', info)
        info = "{SRBX1}" + SRUN.get_base64(SRUN.get_xencode(info, token))
        md5 = SRUN.get_md5(self.pwd, token)
        chksum = token + self.id + token + md5 + token + '1' + token + ip + token + '200' + token + '1' + token + info
        chksum = SRUN.get_sha1(chksum)
        srun_portal_data = {
            "callback": 'jQuery112401316671457983556_' + str(int(time.time() * 1000)),
            "action": 'login',
            'username': self.id,
            'password': '{MD5}' + md5,
            'ac_id': '1',
            'ip': ip,
            'chksum': chksum,
            'info': info,
            'n': '200',
            'type': '1',
            'os': 'windows+10',
            'name': 'windows',
            'double_stack': '0',
            '': int(time.time() * 1000)
        }
        srun_portal_res = requests.get(self.srun_portal, params=srun_portal_data, headers=self.header)
        json_str = re.search(r'\((\{.*})\)', srun_portal_res.text).group(1)
        data = json.loads(json_str)

        if data['res'] != 'ok':
            if data['res'] == 'sign_error' or data['res'] == 'challenge_expire_error':
                return 0
            else:
                return -1
        return data
