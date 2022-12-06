<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>blek! Sail</title>
        <style>
            body {
                font-family: 'Open Sans', sans-serif;
                background: #333333;
                color: #e1e3e1;
            }
            .center {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                padding: 48px 64px;
                border: 1px solid #3e403e;
                box-shadow: 0 1px 2px #3e403e60;
                border-radius: 32px;
                max-width: 600px;
                min-width: 600px;
                background: linear-gradient(0, #303030 0%, #323232 25%, #323232 75%, #343434);
            }
            .center h1 {
                margin: 0;
                padding: 0
            }
            td p, td h5 {
                padding: 0;
                margin: 0;
                font-size: 11pt;
                padding-bottom: 8px
            }
            hr {
                margin: 12px 0;
                margin-bottom: 32px;
                padding: 0
            }
            .side_flag {
                position: fixed;
                top: 0;
                right: 16px;

                width: 32px;
                height: 100%;

                opacity: .7;
                background: linear-gradient(90deg,#5BCEFA 20%,#F5A9B8 20%,40%,#FFFFFF 40%,60%,#F5A9B8 60%,80%,#5BCEFA 80%);
            }
            .side_menu {
                position: fixed;
                top: 14px;
                right: 64px;
            }
            .github_logo {
                border: 2px solid #c2c4c2;
                border-radius: 50%;
                filter: drop-shadow(0 2px 1px #42444220)
            }
        </style>
    </head>
    <body>
        <div class='center'>
            <h1 align='center'>blek! Sail</h1>
            <p align='center'>
                Congratulations, you have set up blek! Sail.
            </p>
            <hr/>
            <h3 align='center'>Why am i seeing this page?</h5>
            <table><tbody>
                <tr>
                    <td style='padding-right:64px'>
                        <h5>If you are a developer...</h5>
                    </td>
                    <td>
                        <h5>If you are an arbitrary user...</h5>
                    </td>
                </tr>
                <tr>
                    <td style='padding-right:64px'>
                        <p>You fucked up with directories.</p>
                    </td>
                    <td>
                        <p>The developer fucked up with directories.</p>
                    </td>
                </tr>
            </tbody></table>
        </div>
        <div class='side_flag'></div>
        <div class='side_menu'>
            <a href='https://github.com/b1ek/sail' target='_blank'><img src='/github.png' class='github_logo' width=32></img></a>
        </div>
    </body>
</html>
