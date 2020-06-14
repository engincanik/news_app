/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.location.handlers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.IntentFilter;

import com.huawei.hms.flutter.location.constants.Action;
import com.huawei.hms.flutter.location.receivers.ActivityIdentificationBroadcastReceiver;

import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;

public class ActivityIdentificationStreamHandler implements StreamHandler {
    private final Context mContext;

    private BroadcastReceiver mBroadcastReceiver;

    public ActivityIdentificationStreamHandler(final Context context) {
        mContext = context;
    }

    @Override
    public void onListen(final Object arguments, final EventSink events) {
        mBroadcastReceiver = new ActivityIdentificationBroadcastReceiver(events);
        mContext.registerReceiver(mBroadcastReceiver, new IntentFilter(Action.PROCESS_IDENTIFICATION.id()));
    }

    @Override
    public void onCancel(final Object arguments) {
        mContext.unregisterReceiver(mBroadcastReceiver);
        mBroadcastReceiver = null;
    }
}
