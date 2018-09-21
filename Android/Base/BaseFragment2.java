package com.wowo.wowo.Base;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;

/**
 * Created by HelloWorld on 2018/3/22.
 */

public class BaseFragment2 extends Fragment {

    /**
     * 传递不带返回值的意图
     * @param pClass
     * @param pBundle
     */
    protected void openActivity(Class<?> pClass, Bundle pBundle) {
        Intent intent = new Intent(getActivity(), pClass);
        if (pBundle != null) {
            intent.putExtras(pBundle);
        }
        startActivity(intent);
    }

    /**
     * 传递带有返回值的activity，简化了意图的代码
     * @param pClass
     * @param pBundle
     * @param requestCode
     */
    protected void openActivity(Class<?> pClass, Bundle pBundle,int requestCode) {
        Intent intent = new Intent(getActivity(), pClass);
        if (pBundle != null) {
            intent.putExtras(pBundle);
        }
        startActivityForResult(intent, requestCode);
    }
}
